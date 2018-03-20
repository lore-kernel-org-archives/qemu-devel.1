Received: from eggs.gnu.org ([2001:4830:134:3::10]:46472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ey5Mf-00071a-EO
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ey5Ma-0006yn-HQ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:42:57 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:40623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ey5Ma-0006x3-Ab
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:42:52 -0400
Received: by mail-pl0-x244.google.com with SMTP id x4-v6so2385295pln.7
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 17:42:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180319131743.3885-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8294a6ab-ea9f-8537-3921-13a3513726c8@twiddle.net>
Date: Tue, 20 Mar 2018 08:42:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180319131743.3885-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] gitmodules: Use the QEMU mirror
 of qemu-palcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

On 03/19/2018 09:17 PM, Peter Maydell wrote:
> We have a mirror of the qemu-palcode repository on
> git.qemu.org; use that instead of the upstream github,
> in line with our general policy of keeping and using
> a mirror for submodules.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
