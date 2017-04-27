Received: from eggs.gnu.org ([2001:4830:134:3::10]:58064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3eXr-0000ss-NZ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3eXr-0002zH-0d
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:12:59 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493263764-18657-1-git-send-email-cota@braap.org>
	<1493263764-18657-9-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4415513e-db6d-ed35-295b-63a2ae7c8f90@twiddle.net>
Date: Thu, 27 Apr 2017 10:12:49 +0200
MIME-Version: 1.0
In-Reply-To: <1493263764-18657-9-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 08/11] target/i386: introduce gen_jr
 helper to generate lookup_and_goto_ptr
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
> This helper will be used by subsequent changes.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   target/i386/translate.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
