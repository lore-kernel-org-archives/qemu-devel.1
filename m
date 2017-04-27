Received: from eggs.gnu.org ([2001:4830:134:3::10]:57399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3eUZ-0006OL-5l
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3eUY-0001XA-E1
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:09:35 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493263764-18657-1-git-send-email-cota@braap.org>
	<1493263764-18657-4-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7f2ce7e7-4000-275f-1e83-7ce1ec8ff44e@twiddle.net>
Date: Thu, 27 Apr 2017 10:09:24 +0200
MIME-Version: 1.0
In-Reply-To: <1493263764-18657-4-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/11] tcg: introduce goto_ptr opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On 04/27/2017 05:29 AM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   tcg/aarch64/tcg-target.h | 1 +
>   tcg/arm/tcg-target.h     | 1 +
>   tcg/i386/tcg-target.h    | 1 +
>   tcg/ia64/tcg-target.h    | 1 +
>   tcg/mips/tcg-target.h    | 1 +
>   tcg/ppc/tcg-target.h     | 1 +
>   tcg/s390/tcg-target.h    | 1 +
>   tcg/sparc/tcg-target.h   | 1 +
>   tcg/tcg-opc.h            | 1 +
>   tcg/tci/tcg-target.h     | 1 +
>   10 files changed, 10 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
