Received: from eggs.gnu.org ([2001:4830:134:3::10]:48876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavdr-0005rJ-4p
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavdn-0006Kl-2b
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:36:27 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:33975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cavdm-0006Kd-VO
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:36:23 -0500
Received: by mail-yw0-x244.google.com with SMTP id v73so8491148ywg.1
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 18:36:22 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
	<20170125123430.GG7836@lianli.shorne-pla.net>
	<39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
	<20170126131229.GB16014@lianli.shorne-pla.net>
	<ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
	<20170201100423.GE21641@lianli.shorne-pla.net>
	<c840eff0-2be7-07d7-eae9-4cded569d146@twiddle.net>
	<20170202143455.GB32144@lianli.shorne-pla.net>
	<20170203151449.GC32144@lianli.shorne-pla.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fbaa2670-fa68-4c31-6197-bef2b5eb752c@twiddle.net>
Date: Mon, 6 Feb 2017 18:36:04 -0800
MIME-Version: 1.0
In-Reply-To: <20170203151449.GC32144@lianli.shorne-pla.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org, openrisc@lists.librecores.org

On 02/03/2017 07:14 AM, Stafford Horne wrote:
> I tried your tgt-or1k-2 branch with my latest kernel and have no issues.

Ok, excellent, thanks.  I'll send a pull for that branch then.


r~
