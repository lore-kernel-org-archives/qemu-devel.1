Received: from eggs.gnu.org ([2001:4830:134:3::10]:50736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1emNT0-0000ah-7r
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1emNSz-0001ez-HU
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:37:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180215042900.16078-14-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-14-f4bug@amsat.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 15 Feb 2018 09:37:04 -0800
Message-ID: <CAMo8BfJoU3b8aphOs1szfGh9StkHP-W3tuxA7V6aqPE1YgJovA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/30] hw/xtensa: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>

On Wed, Feb 14, 2018 at 8:28 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> It ease code review, unit is explicit.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/xtensa/xtfpga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

Michael, could you please take it into the qemu-trivial?

--=20
Thanks.
-- Max
