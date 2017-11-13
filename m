Received: from eggs.gnu.org ([2001:4830:134:3::10]:47912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eE9pk-0007qn-3U
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eE9pj-0007cz-82
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:11:08 -0500
Date: Mon, 13 Nov 2017 13:40:45 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <29f80a56-df32-0eb5-0152-683c85a7e421@amsat.org>
Message-ID: <nycvar.YSQ.7.76.1711131339450.10115@wniryva>
References: <20171111081111.32724-1-ppandit@redhat.com>
	<29f80a56-df32-0eb5-0152-683c85a7e421@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] highbank: validate register offset
 before access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Moguofang <moguofang@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh@kernel.org>

  Hello Philippe,

+-- On Sun, 12 Nov 2017, Philippe Mathieu-Daud=C3=A9 wrote --+
| I'd rather use:
|=20
|            "highbank: bad write offset 0x%" HWADDR_PRIx "\n", offset);

Sent revised patch v2. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
