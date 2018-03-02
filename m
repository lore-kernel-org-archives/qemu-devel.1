Received: from eggs.gnu.org ([2001:4830:134:3::10]:59721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erheT-00058Y-Jn
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erheP-0001TE-8P
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:10:57 -0500
Date: Fri, 2 Mar 2018 11:10:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180302111048.664d112e.cohuck@redhat.com>
In-Reply-To: <1519944838-12430-1-git-send-email-cota@braap.org>
References: <1519944838-12430-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv1 00/14] Translation loop conversion for
 sh4/sparc/mips/s390x/openrisc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>

On Thu,  1 Mar 2018 17:53:44 -0500
"Emilio G. Cota" <cota@braap.org> wrote:

> [ What is this all about? See this message:
>   http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04785.html ]
> 
> Merged the separate patchsets I sent in the last couple of weeks into
> one set. This will be easier to merge since it will avoid potential
> merge conflicts due to adding max_insns to dc->base.

So, the plan is to merge that as a series? I'll go ahead and ack the
s390x patches, then.
