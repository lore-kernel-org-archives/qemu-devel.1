Received: from eggs.gnu.org ([2001:4830:134:3::10]:37861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPbEi-0002Lf-6g
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 17:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPbEh-0007Cq-AL
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 17:07:56 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497639397-19453-1-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ee142dc2-9d34-169a-af1e-f24d2e211286@twiddle.net>
Date: Mon, 26 Jun 2017 14:07:40 -0700
MIME-Version: 1.0
In-Reply-To: <1497639397-19453-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] cpu_env in gen-icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>

On 06/16/2017 11:56 AM, Emilio G. Cota wrote:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03771.html
> 
> Changes from v1:
> 
> - Use tcg_ctx.tcg_env instead of passing cpu_env around as suggested
>    by Richard.
> - Added Richard's R-b tag to patch 1.

Applied to the tcg queue.


r~
