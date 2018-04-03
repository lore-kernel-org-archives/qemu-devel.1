Received: from eggs.gnu.org ([2001:4830:134:3::10]:41177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1f3O8D-0007Mi-C2
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1f3O8A-0004Ku-RO
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:45:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1f3O8A-0004HV-Lo
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:45:54 -0400
From: Laurent Vivier <lvivier@redhat.com>
References: <20180328133152.24623-1-lvivier@redhat.com>
	<cb19950a-9b8e-90be-49df-b145900e2958@redhat.com>
Message-ID: <5398bc08-58ad-32ac-8125-e079441216e7@redhat.com>
Date: Tue, 3 Apr 2018 17:45:38 +0200
MIME-Version: 1.0
In-Reply-To: <cb19950a-9b8e-90be-49df-b145900e2958@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: fix 16-byte vector operations
 detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Miroslav Rezanina <mrezanin@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 29/03/2018 18:54, Laurent Vivier wrote:
> Hi,
> 
> I think it would be good to have this fix (or something similar) in -rc2.

So no one agrees with that?

Thanks,
Laurent
