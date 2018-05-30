Received: from eggs.gnu.org ([2001:4830:134:3::10]:48319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAJt-0004Me-RE
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAJo-0004Dq-Qy
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:15:53 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fOAJo-0004Df-KT
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:15:48 -0400
Received: by mail-pf0-x243.google.com with SMTP id w129-v6so9773897pfd.3
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:15:48 -0700 (PDT)
Date: Thu, 31 May 2018 08:15:45 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180530231545.GW3652@lianli.shorne-pla.net>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
	<20180527141324.11937-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527141324.11937-7-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 06/20] target/openrisc: Exit the TB after
 l.mtspr
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

On Sun, May 27, 2018 at 09:13:10AM -0500, Richard Henderson wrote:
> A store to SR changes interrupt state, which should return
> to the main loop to recognize that state.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stafford Horne <shorne@gmail.com>

 
