Received: from eggs.gnu.org ([2001:4830:134:3::10]:54426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1chCTB-0002LT-Pp
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1chCTB-0002Sy-42
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:47:21 -0500
References: <20170222112338.25492-1-clement.deschamps@antfield.fr>
	<20170222112338.25492-3-clement.deschamps@antfield.fr>
	<CAFEAcA_jPaQxfoXKz82WaQ+62krkbQ7RCm66DeELj30jOE7_Xg@mail.gmail.com>
From: Clement Deschamps <clement.deschamps@antfield.fr>
Message-ID: <5e429ced-9e7b-cf9e-ed73-1b9dd8baa46b@antfield.fr>
Date: Fri, 24 Feb 2017 10:47:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_jPaQxfoXKz82WaQ+62krkbQ7RCm66DeELj30jOE7_Xg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WCpnN4GM5KEoATTgS600qIr1QjMf4Lrlg"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] bcm2835_gpio: add bcm2835 gpio
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Baumann <andrew.baumann@microsoft.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WCpnN4GM5KEoATTgS600qIr1QjMf4Lrlg
From: Clement Deschamps <clement.deschamps@antfield.fr>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Andrew Baumann <andrew.baumann@microsoft.com>
Message-ID: <5e429ced-9e7b-cf9e-ed73-1b9dd8baa46b@antfield.fr>
Subject: Re: [PATCH v2 2/3] bcm2835_gpio: add bcm2835 gpio controller
References: <20170222112338.25492-1-clement.deschamps@antfield.fr>
 <20170222112338.25492-3-clement.deschamps@antfield.fr>
 <CAFEAcA_jPaQxfoXKz82WaQ+62krkbQ7RCm66DeELj30jOE7_Xg@mail.gmail.com>
In-Reply-To: <CAFEAcA_jPaQxfoXKz82WaQ+62krkbQ7RCm66DeELj30jOE7_Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 08:08 PM, Peter Maydell wrote:

> Do we also need to call the SD card object's reset method?

On the real Raspberry Pi, I think that the card is not reset when
switching SD controllers.

> Apart from my comments above about the card-reparenting function
> this looks OK to me (and I'd like to squeeze it into 2.9 if we
> can; deadline for "patches reviewed and in pull requests is very
> near though, 28th).

Sounds great! I'll send a v3 ASAP.


Best,
Cl=C3=A9ment



--WCpnN4GM5KEoATTgS600qIr1QjMf4Lrlg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJSBAEBCAA8FiEEaNi9eUaRP9BYKowJomWY3rxByn8FAliwASceHGNsZW1lbnQu
ZGVzY2hhbXBzQGFudGZpZWxkLmZyAAoJEKJlmN68Qcp/eG8QAJzyiFOW04/aRzNV
BeeEiKHd9pHT4YIZzgAd3zutMz3vPnlXsyfkYXq/J5z07vjghF1CyuMjZkYHu8eR
82nMmIlx6F+ubmX52kUl/V9FYTIraAZukRdhy8ny3lq7UYt0JDOO1gzgxls69+uJ
jXORsuVr8Kxf0ZMKlwvillbOG49JZWbn4452qPxg/Pu4DANTocfrIN7gyevZkBbk
EPovez5oeA+FuCPmpAbiz90r2/ImqidOnv1R/w8bSETV6V8yhjDfGi8c+CvItRK5
6N44eudxmD1YK1w234Zx3+GWaRhG0D0Cx4nNl6zG2zodsZf0dx70odWSAZe06h+L
5rWUBJGTGwF4e46RjXEpKo9+gYfjFvSFxo2Nr/JVYgV/vnbmT9H0VkLBD/j5FppN
kVc2b6rBbo4MerlfyJ4vrX7a29CkUsMItJFKWfn21j5HMznMAV8QZIYzm/OjH4UB
2U51P375neJT1SyHujGavIjO9PNsAGWtCzh7pHZfYL7dahCfG7aPaiww7eMfAeWS
+dxozKnNXQ0qDkMmdJJ8N+J2ej73eMD1SUAoj4RHSUMO1vOw6OQy50h1rQAojNlb
IrdeUgM1uFRnfv4A12+4kkhtdwWVV5UNnNdzdlyt7lLVkg+1om0iaE7hh2budQwE
BhpLMCRYItZOkID8XUjhPb77omnP
=Xdmh
-----END PGP SIGNATURE-----

--WCpnN4GM5KEoATTgS600qIr1QjMf4Lrlg--
