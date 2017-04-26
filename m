Received: from eggs.gnu.org ([2001:4830:134:3::10]:50284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3IFz-0005xg-K2
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3IFy-0003s7-UQ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:25:03 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493187803-4510-1-git-send-email-cota@braap.org>
	<1493187803-4510-10-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3814e69a-823a-0fb8-da7f-071b61856414@twiddle.net>
Date: Wed, 26 Apr 2017 10:24:53 +0200
MIME-Version: 1.0
In-Reply-To: <1493187803-4510-10-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/10] target/i386: optimize indirect
 branches
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

On 04/26/2017 08:23 AM, Emilio G. Cota wrote:
> Speed up indirect branches by jumping to the target if it is valid.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
