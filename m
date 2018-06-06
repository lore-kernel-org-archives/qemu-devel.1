Received: from eggs.gnu.org ([2001:4830:134:3::10]:35450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fQbXb-00068x-GG
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fQbXa-0003dy-P8
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:44:07 -0400
MIME-Version: 1.0
In-Reply-To: <20180606152128.449-12-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
	<20180606152128.449-12-f4bug@amsat.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 6 Jun 2018 09:44:05 -0700
Message-ID: <CAMo8BfK-86N1__q5A4RBAOz3g3JZ_6ibcp8SZCPmk3vJakWQ-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 11/11] target/xtensa: Add trailing '\n'
 to qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On Wed, Jun 6, 2018 at 8:21 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> RFC because I think the qemu_log_mask() was previously intended to concat=
enate
> output to stderr... (multiple registers described on a single line).

No, there were no such intent.

>  target/xtensa/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
