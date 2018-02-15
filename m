Received: from eggs.gnu.org ([2001:4830:134:3::10]:51885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emLAD-0000HN-1R
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emLAC-0007xq-1n
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:09:32 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <e86b9596-56a5-a41e-452b-7923d3d74bcf@redhat.com>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-17-f4bug@amsat.org>
	<e86b9596-56a5-a41e-452b-7923d3d74bcf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 12:09:30 -0300
Message-ID: <CAAdtpL5xxiyhjrKw+WrfLEwdYhJ2Jaa3kmq8QuTZvTfhvGyQHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/30] hw/sh4: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, Feb 15, 2018 at 11:43 AM, Eric Blake <eblake@redhat.com> wrote:
> On 02/14/2018 10:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> It ease code review, unit is explicit.
>
>
> I noticed it here, then see it occurs throughout the series:
> s/ease/eases/ in the commit message.

Oops, thanks Eric I'll fix in respin.

>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   hw/block/tc58128.c | 2 +-
>>   hw/sh4/r2d.c       | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
