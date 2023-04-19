
![Logo](https://raw.githubusercontent.com/iRawNewton/flutter-numberology/main/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png)


# Numberology

Numberology is a Flutter app that generates random, trivial, math, date, and year facts about numbers using the Numbers API.

## API Reference

#### Get facts on numbers

```http
  GET /api/number/type
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `number` | `int` | **Required**. Any integer or keyword random |
|`type`| `string` | **Optional**. Type is one of trivia, math, date, or year. Defaults to trivia if omitted.|

#### Example

```http
  GET http://numbersapi.com/42/trivia
```




## Tech Stack

**SDK:** Flutter, Dart



## License

![GitHub](https://img.shields.io/github/license/irawnewton/flutter-numberology?style=for-the-badge)


## Feedback

If you have any feedback, please reach out to me at [![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/irawnewton/)

