Received: from eggs.gnu.org ([2001:4830:134:3::10]:50672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh2C-0004ur-0i
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh26-0007zU-AA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:00:20 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38879)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSh26-0007ya-0M
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:00:14 -0400
References: <20180612005145.3375-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f2c4182f-0961-bc51-c894-907e0e28d6ba@vivier.eu>
Date: Tue, 12 Jun 2018 13:00:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180612005145.3375-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/19] linux-user: Split do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Le 12/06/2018 à 02:51, Richard Henderson a écrit :
> Version 3 does not attempt the whole thing in one go,
> and does attempt to incorporate strace into the reorg.

I've included your first four patches in my last linux-user pull-request.

Thanks,
Laurent
