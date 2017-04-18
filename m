Received: from eggs.gnu.org ([2001:4830:134:3::10]:48698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0O53-0001kD-OV
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0O50-0000ZC-Fp
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:01:45 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d0O50-0000YG-8M
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:01:42 -0400
Received: by mail-wr0-x241.google.com with SMTP id u18so23598170wrc.1
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 01:01:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
	<f8e2371c7a99cc6694b65d5be4f6c265dceae66a.1492384862.git.shorne@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a0337476-529d-9efe-c4c2-5e63c9aa5ed7@twiddle.net>
Date: Tue, 18 Apr 2017 01:01:37 -0700
MIME-Version: 1.0
In-Reply-To: <f8e2371c7a99cc6694b65d5be4f6c265dceae66a.1492384862.git.shorne@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] target/openrisc: add numcores and
 coreid support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, qemu-devel@nongnu.org
Cc: openrisc@lists.librecores.org

On 04/16/2017 04:23 PM, Stafford Horne wrote:
> These are used to identify the processor in SMP system.  Their
> definition has been defined in verilog cores but it not yet part of the
> spec but it will be soon.
>
> The proposal for this is available:
>   https://openrisc.io/proposals/core-identifier-and-number-of-cores
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
