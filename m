Received: from eggs.gnu.org ([2001:4830:134:3::10]:50321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1cFKLA-0001kN-Hf
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1cFKL6-0000da-K0
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:31:49 -0500
Received: from ssl.serverraum.org ([2a01:4f8:130:84d6::1:2]:33955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1cFKL6-0000aY-5K
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:31:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Dec 2016 13:31:37 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <1481285870-3396-14-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-14-git-send-email-thuth@redhat.com>
Message-ID: <81cd1ca1dabdf3c3228b3c4092e13b77@walle.cc>
Subject: Re: [Qemu-devel] [PATCH 13/20] lm32: Move CPU files to target/
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

Am 2016-12-09 13:17, schrieb Thomas Huth:
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                | 2 +-
>  {target-lm32 => target/lm32}/Makefile.objs | 0
>  {target-lm32 => target/lm32}/README        | 0
>  {target-lm32 => target/lm32}/TODO          | 0
>  {target-lm32 => target/lm32}/cpu-qom.h     | 0
>  {target-lm32 => target/lm32}/cpu.c         | 0
>  {target-lm32 => target/lm32}/cpu.h         | 0
>  {target-lm32 => target/lm32}/gdbstub.c     | 0
>  {target-lm32 => target/lm32}/helper.c      | 0
>  {target-lm32 => target/lm32}/helper.h      | 0
>  {target-lm32 => target/lm32}/lm32-semi.c   | 0
>  {target-lm32 => target/lm32}/machine.c     | 0
>  {target-lm32 => target/lm32}/op_helper.c   | 0
>  {target-lm32 => target/lm32}/translate.c   | 0
>  14 files changed, 1 insertion(+), 1 deletion(-)
>  rename {target-lm32 => target/lm32}/Makefile.objs (100%)
>  rename {target-lm32 => target/lm32}/README (100%)
>  rename {target-lm32 => target/lm32}/TODO (100%)
>  rename {target-lm32 => target/lm32}/cpu-qom.h (100%)
>  rename {target-lm32 => target/lm32}/cpu.c (100%)
>  rename {target-lm32 => target/lm32}/cpu.h (100%)
>  rename {target-lm32 => target/lm32}/gdbstub.c (100%)
>  rename {target-lm32 => target/lm32}/helper.c (100%)
>  rename {target-lm32 => target/lm32}/helper.h (100%)
>  rename {target-lm32 => target/lm32}/lm32-semi.c (100%)
>  rename {target-lm32 => target/lm32}/machine.c (100%)
>  rename {target-lm32 => target/lm32}/op_helper.c (100%)
>  rename {target-lm32 => target/lm32}/translate.c (100%)

Acked-by: Michael Walle <michael@walle.cc>
