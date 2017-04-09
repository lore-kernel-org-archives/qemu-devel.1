Received: from eggs.gnu.org ([2001:4830:134:3::10]:50757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cxUzx-0004Zh-U5
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cxUzu-0005Jr-S4
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:48:33 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Sun, 9 Apr 2017 17:10:37 +0000
Message-ID: <AM5P194MB01298117DD72E3E7DEB2EC12C80E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
	<20170408065107.GG27571@umbus>
	<AM5P194MB01292723DDB978AC78F8FDD7C80E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>,
	<871st1wt9q.fsf@linaro.org>
In-Reply-To: <871st1wt9q.fsf@linaro.org>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "programmingkidx@gmail.com" <programmingkidx@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>

Hi Alex,

>Have you declared the memory ordering for the guest?

Nope didnt know was necessary i just add the standard -m 2047


>See ca759f9e387db87e1719911f019bc60c74be9ed8 for an example.

watching it about

Thanks
Luigi
