Received: from eggs.gnu.org ([2001:4830:134:3::10]:37909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFg5f-0004Ig-Ju
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFg5W-0004pj-Kr
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:54:19 -0400
References: <1539080467-2976-1-git-send-email-liq3ea@gmail.com>
	<CAFEAcA9HOhtPbAOrbvRQfrnfcq14WuW+a5w=EXG3+-9t6Wfx5Q@mail.gmail.com>
	<CAKXe6SJGpJVeaqs5boqWZqtVjKornk6TEEWhUd7TFnnfb-eOSg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <92171f41-9a09-ecb4-ac92-63d991a3d41f@vivier.eu>
Date: Thu, 25 Oct 2018 14:54:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJGpJVeaqs5boqWZqtVjKornk6TEEWhUd7TFnnfb-eOSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] memory.h: fix types in
 comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

On 09/10/2018 11:37, Li Qiang wrote:
> 
> 
> Peter Maydell <peter.maydell@linaro.org
> <mailto:peter.maydell@linaro.org>> 于2018年10月9日周二 下午6:26写道：
> 
>     On 9 October 2018 at 11:21, Li Qiang <liq3ea@gmail.com
>     <mailto:liq3ea@gmail.com>> wrote:
>     > Signed-off-by: Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>>
>     > ---
>     >  include/exec/memory.h | 6 +++---
>     >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
>     Thanks. Contents of patch
>     Reviewed-by: Peter Maydell <peter.maydell@linaro.org
>     <mailto:peter.maydell@linaro.org>>
> 
>     but the commit message should say "fix typos", not "fix types"
>     (a 'typo' is a typing mistake; a 'type' is something like "uint32_t".)
> 
> 
> Indeed, hope the maintainer can fix this typo when queuing this patch, :)
> 
> In additon, Cc: qemu-trivial@nongnu.org <mailto:qemu-trivial@nongnu.org>
>  

Applied to qemu-trivial branch

Thanks,
Laurent
