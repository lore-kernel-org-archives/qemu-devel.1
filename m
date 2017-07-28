Received: from eggs.gnu.org ([2001:4830:134:3::10]:35913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1db3hm-0002iv-Qa
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1db3hj-0000Q7-BF
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:45:18 -0400
References: <20170727024224.22900-1-f4bug@amsat.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <12b23d70-abe8-18f3-f08e-78aecd818289@msgid.tls.msk.ru>
Date: Fri, 28 Jul 2017 14:45:14 +0300
MIME-Version: 1.0
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 00/20] fix bugs reported by
 Clang Static Analyzer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

27.07.2017 05:42, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> This series is the result of [now NOT] having fun with Clang's Static A=
nalyzer
> (see https://clang-analyzer.llvm.org/).

Applied almost all to -trivial, except of the ones wich had NACKs and que=
stions.

Thanks,

/mjt
