Received: from eggs.gnu.org ([2001:4830:134:3::10]:42507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9c8W-0003Z8-El
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9c6Q-0003fK-BG
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:26:07 -0400
References: <cover.1537984851.git.jcody@redhat.com>
	<d56d7c6592e7d68aa72764e9616878394bffbc14.1537984851.git.jcody@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f79aa27a-dac3-a333-f194-0cbf7b31175b@redhat.com>
Date: Mon, 8 Oct 2018 16:25:57 -0400
MIME-Version: 1.0
In-Reply-To: <d56d7c6592e7d68aa72764e9616878394bffbc14.1537984851.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] MAINTAINERS: Replace myself with
 John Snow for block jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jeff@codyprime.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com



On 09/26/2018 02:05 PM, Jeff Cody wrote:
> I'll not be involved with day-to-day qemu development, and John
> Snow is a block jobs wizard.  Have him take over block job
> maintainership duties.
> 

... I didn't realize he wrote it like this, and I am told I should
accept compliments, ...

Well, factually it's Kevin and I who have worked on them the most
lately, and Kevin's already got enough stuff, so I think it's okay for
me to take this unless someone disagrees.

> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce7c351afa..0e22b795e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1455,7 +1455,7 @@ F: include/scsi/*
>  F: scsi/*
>  
>  Block Jobs
> -M: Jeff Cody <jcody@redhat.com>
> +M: John Snow <jsnow@redhat.com>

Acked-by: John Snow <jsnow@redhat.com>

`*~ pour one out for your homies ~*'

>  L: qemu-block@nongnu.org
>  S: Supported
>  F: blockjob.c
> @@ -1468,7 +1468,7 @@ F: block/commit.c
>  F: block/stream.c
>  F: block/mirror.c
>  F: qapi/job.json
> -T: git git://github.com/codyprime/qemu-kvm-jtc.git block
> +T: git git://github.com/jnsnow/qemu.git jobs
>  
>  Block QAPI, monitor, command line
>  M: Markus Armbruster <armbru@redhat.com>
> 
