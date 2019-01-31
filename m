Received: from eggs.gnu.org ([209.51.188.92]:51781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpKVA-0000qT-1x
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpKIt-0001vT-R9
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:55:24 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpKIt-0001ub-BQ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:55:23 -0500
Received: by mail-pl1-x643.google.com with SMTP id e11so2079213plt.11
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:55:23 -0800 (PST)
References: <1548769067-20792-1-git-send-email-thuth@redhat.com>
	<20190129145156.6719b8a4.cohuck@redhat.com>
	<e3dfae55-8733-bd01-1f13-422f343fb258@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <509e6dca-8c78-947f-cf91-15ad02510bba@linaro.org>
Date: Thu, 31 Jan 2019 13:55:19 -0800
MIME-Version: 1.0
In-Reply-To: <e3dfae55-8733-bd01-1f13-422f343fb258@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Fix LGPL version in the file
 header comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 1/30/19 7:01 AM, Eric Blake wrote:
> On 1/29/19 7:51 AM, Cornelia Huck wrote:
>> Given that there have been several of these cases (and that there's a
>> lot of boilerplate in general): Should we adopt SPDX license
>> identifiers for QEMU, as the Linux kernel did? They also discovered and
>> fixed some problems/oddities while at it.
> 
> I'm also in favor of SPDX license identifiers - their brevity and
> machine-parsability favors more accurate usage and fewer copy/paste
> mistake propagation.

+1.


r~
