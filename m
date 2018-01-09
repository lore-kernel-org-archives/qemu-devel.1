Received: from eggs.gnu.org ([2001:4830:134:3::10]:32844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1eYhiT-00084k-Dc
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 19:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1eYhiO-0002u3-Nh
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 19:24:32 -0500
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 9 Jan 2018 00:24:24 +0000
Message-ID: <CY4PR21MB04692645342E2571EF5FA87F9E100@CY4PR21MB0469.namprd21.prod.outlook.com>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<20171229174933.1781-34-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-34-f4bug@amsat.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 33/42] hw/arm/bcm2835_peripherals:
 implement SDHCI Spec v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Alistair
	Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, =?utf-8?B?R3LDqWdvcnkgRXN0cmFkZSBncmVnb3J5IC4gZXN0cmFkZSBAIGdtYWlsIC4g?= =?utf-8?Q?com_Clement_Deschamps?= <clement.deschamps@antfield.fr>, Ashok
	kumar <ashoks@broadcom.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

PiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSBbbWFpbHRvOnBoaWxpcHBlLm1hdGhpZXUu
ZGF1ZGVAZ21haWwuY29tXQ0KPiBTZW50OiBGcmlkYXksIDI5IERlY2VtYmVyIDIwMTcgMDk6NDkN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxmNGJ1Z0BhbXNh
dC5vcmc+DQo+IC0tLQ0KPiANCj4gTm90ZSwgdGhlIGJjbTI4MzUgc2VlbXMgdG8gaGF2ZSAxS0Ig
bWluaW11bSBibG9ja3NpemUsIGhvd2V2ZXIgdGhlDQo+IGN1cnJlbnQNCj4gbW9kZWwgaXMgaW1w
bGVtZW50ZWQgd2l0aCA1MTJCLg0KPiANCj4gQ2FuIHNvbWVvbmUgd2l0aCBhY2Nlc3MgdG8gdGhl
IGRhdGFzaGVldHMgdmVyaWZ5Pw0KDQpUaGUgcHVibGljIEJDTTI4MzUgcGVyaXBoZXJhbHMgZGF0
YXNoZWV0IHNheXM6DQogICJUaGUgRU1NQyBtb2R1bGUgcmVzdHJpY3RzIHRoZSBtYXhpbXVtIGJs
b2NrIHNpemUgdG8gdGhlIHNpemUgb2YgdGhlIGludGVybmFsIGRhdGEgRklGTw0KICB3aGljaCBp
cyAxayBieXRlcy4iDQouLi4gc28gSSB0aGluayB5b3VyIHBhdGNoIGlzIGNvcnJlY3QuDQoNCkFu
ZHJldw0K
