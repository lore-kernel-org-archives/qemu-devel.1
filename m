Received: from eggs.gnu.org ([2001:4830:134:3::10]:48268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er53R-00068X-IY
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er53O-0003gE-Pm
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:58:09 -0500
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:42194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er53O-0003fs-KK
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:58:06 -0500
Received: by mail-pl0-x22d.google.com with SMTP id 93-v6so1848036plc.9
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 08:58:06 -0800 (PST)
References: <20180227143852.11175-1-alex.bennee@linaro.org>
	<CAFEAcA8LEG=bzXrj3etTdf_q3-AcMVfCCqSGQ2OkXUPGBHkMBQ@mail.gmail.com>
	<87woyxutms.fsf@linaro.org>
	<CAFEAcA9LGHjneP9qi0s2jyQE=hz=fa6fadgv-0Znujr62H-0NQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <51845d05-364d-864b-9380-0d8b09776efb@linaro.org>
Date: Wed, 28 Feb 2018 08:58:02 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9LGHjneP9qi0s2jyQE=hz=fa6fadgv-0Znujr62H-0NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 00/31] Add ARMv8.2
 half-precision functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 02/28/2018 07:02 AM, Peter Maydell wrote:
> Do you have a feel for how much work the AArch32 side is?

Based on my experience adding fcmla support to aa32, probably less than a week.


r~
