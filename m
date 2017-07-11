Received: from eggs.gnu.org ([2001:4830:134:3::10]:33468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUzjq-00060Z-71
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUzjp-0007KG-Is
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:18:22 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUzjp-0007K1-Eu
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:18:21 -0400
Received: by mail-qk0-x242.google.com with SMTP id p21so26212qke.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 11:18:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0ed8756e-460c-8f12-220f-1921688a8978@twiddle.net>
Date: Tue, 11 Jul 2017 08:18:16 -1000
MIME-Version: 1.0
In-Reply-To: <20170711175937.23140-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/6] arm: fixes for eret,
 isb and DISAS_UPDATE handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org
Cc: qemu-devel@nongnu.org

On 07/11/2017 07:59 AM, Alex Bennée wrote:
> Hopefully there isn't anything else that needs fixing so I guess the
> next question is who's tree should this go through?

I'm happy with this going through the arm tree.


r~
