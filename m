Received: from eggs.gnu.org ([2001:4830:134:3::10]:58128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeYh-0006vK-DU
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeYf-0001za-2J
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:33:09 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeYe-0001yq-RW
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:33:08 -0400
Received: by mail-pg0-x243.google.com with SMTP id e11-v6so1686961pgq.0
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:33:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Message-ID: <6c2c6992-d275-cf31-8904-be50782146bb@linaro.org>
Date: Fri, 1 Jun 2018 00:33:05 -0700
MIME-Version: 1.0
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/33] linux-user: Begin splitting
 do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

On 06/01/2018 12:30 AM, Richard Henderson wrote:
> This function is, as I think everyone will agree, way too large.
> This is about a third of the complete change, but I thought I'd
> get some feedback on the method and form before I go any farther.

Bah.  I also meant to say

Based-on: 20180531224911.23725-1-richard.henderson@linaro.org

that is, the interp_prefix patch set from earlier today.


r~
