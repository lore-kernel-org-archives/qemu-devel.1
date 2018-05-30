Received: from eggs.gnu.org ([2001:4830:134:3::10]:48978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOANf-0006nw-S4
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOANd-0005cK-3n
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:19:47 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fOANc-0005c5-TF
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:19:45 -0400
Received: by mail-pf0-x244.google.com with SMTP id e9-v6so9773637pfi.4
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:19:44 -0700 (PDT)
Date: Thu, 31 May 2018 08:19:42 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180530231942.GY3652@lianli.shorne-pla.net>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
	<20180527141324.11937-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527141324.11937-6-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 05/20] target/openrisc: Split out is_user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Sun, May 27, 2018 at 09:13:09AM -0500, Richard Henderson wrote:
> This allows us to limit the amount of ifdefs and isolate
> the test for usermode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stafford Horne <shorne@gmail.com>

 
