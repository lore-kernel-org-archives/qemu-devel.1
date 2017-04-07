Received: from eggs.gnu.org ([2001:4830:134:3::10]:48957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cwYqW-0003ng-07
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 14:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cwYqV-0000GD-3U
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 14:42:56 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:34397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cwYqU-0000Fy-UY
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 14:42:55 -0400
Received: by mail-pg0-x230.google.com with SMTP id 21so74188697pgg.1
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 11:42:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170405132503.32125-1-alex.bennee@linaro.org>
	<20170405132503.32125-12-alex.bennee@linaro.org>
	<5ee6d2cb-d3e5-8b28-6a73-2d84c44ce614@redhat.com>
	<87k26wa1ry.fsf@linaro.org>
	<2061307774.11920398.1491567568031.JavaMail.zimbra@redhat.com>
	<87inmg9x64.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a4ac932f-1aae-f841-9f85-1001f0142454@twiddle.net>
Date: Fri, 7 Apr 2017 11:42:51 -0700
MIME-Version: 1.0
In-Reply-To: <87inmg9x64.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/12] cpus: call cpu_update_icount on
 read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: dovgaluk@ispras.ru, peter maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, mttcg@greensocs.com, fred konrad <fred.konrad@greensocs.com>, a rigo <a.rigo@virtualopensystems.com>, cota@braap.org, bobby prani <bobby.prani@gmail.com>, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 04/07/2017 06:14 AM, Alex Bennée wrote:
>> Sorry, I meant we should generate TCG opcodes for the translation in
>> gen_io_start.
> Ahh OK. I think this is 2.10 stuff though right?
>

Definitely.


r~
