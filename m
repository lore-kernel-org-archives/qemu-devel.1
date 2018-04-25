Received: from eggs.gnu.org ([2001:4830:134:3::10]:41382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB8Ds-0006Wq-SI
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB8Dp-00025R-PS
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:23:48 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB8Dp-00025E-K2
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:23:45 -0400
Received: by mail-pf0-x242.google.com with SMTP id o16so13624790pfk.9
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 17:23:45 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-22-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9518905c-16b4-81a0-5e77-db55d692d781@linaro.org>
Date: Tue, 24 Apr 2018 14:23:40 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 21/46] tests/tcg/i386: fix
 test-i386-fprem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 05:23 AM, Alex Bennée wrote:
> Remove dependencies on QEMU's source tree and build directly.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/i386/test-i386-fprem.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
