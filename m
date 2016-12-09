Received: from eggs.gnu.org ([2001:4830:134:3::10]:48680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cFPg6-0000ig-Sx
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cFPg3-00004s-O8
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:13:50 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cFPg3-0008S3-J5
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:13:47 -0500
Received: by mail-io0-f194.google.com with SMTP id f73so8449840ioe.2
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 10:13:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481285870-3396-20-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-20-git-send-email-thuth@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 9 Dec 2016 10:12:24 -0800
Message-ID: <CAMo8BfKjZwq+orMS3dcq7uKgZSuJFr1vnTMMH7dSeFgnnxX-LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 19/20] xtensa: Move CPU files to target/
 folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Fri, Dec 9, 2016 at 4:17 AM, Thomas Huth <thuth@redhat.com> wrote:
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                               | 2 +-
>  {target-xtensa => target/xtensa}/Makefile.objs            | 0
>  {target-xtensa => target/xtensa}/core-dc232b.c            | 0
>  {target-xtensa => target/xtensa}/core-dc232b/core-isa.h   | 0
>  {target-xtensa => target/xtensa}/core-dc232b/gdb-config.c | 0
>  {target-xtensa => target/xtensa}/core-dc233c.c            | 0
>  {target-xtensa => target/xtensa}/core-dc233c/core-isa.h   | 0
>  {target-xtensa => target/xtensa}/core-dc233c/gdb-config.c | 0
>  {target-xtensa => target/xtensa}/core-fsf.c               | 0
>  {target-xtensa => target/xtensa}/core-fsf/core-isa.h      | 0
>  {target-xtensa => target/xtensa}/cpu-qom.h                | 0
>  {target-xtensa => target/xtensa}/cpu.c                    | 0
>  {target-xtensa => target/xtensa}/cpu.h                    | 0
>  {target-xtensa => target/xtensa}/gdbstub.c                | 0
>  {target-xtensa => target/xtensa}/helper.c                 | 0
>  {target-xtensa => target/xtensa}/helper.h                 | 0
>  {target-xtensa => target/xtensa}/import_core.sh           | 0
>  {target-xtensa => target/xtensa}/monitor.c                | 0
>  {target-xtensa => target/xtensa}/op_helper.c              | 0
>  {target-xtensa => target/xtensa}/overlay_tool.h           | 0
>  {target-xtensa => target/xtensa}/translate.c              | 0
>  {target-xtensa => target/xtensa}/xtensa-semi.c            | 0
>  tests/tcg/xtensa/Makefile                                 | 2 +-
>  23 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
