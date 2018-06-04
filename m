Received: from eggs.gnu.org ([2001:4830:134:3::10]:55961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPoqr-0007uu-6C
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPoqq-0005S2-7I
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:44:45 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPoqo-0005P4-M7
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:44:44 -0400
Received: by mail-oi0-x242.google.com with SMTP id t22-v6so24836849oih.6
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 05:44:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F201CAF085@DGGEMA503-MBX.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F201CAF085@DGGEMA503-MBX.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 13:44:21 +0100
Message-ID: <CAFEAcA_Su0SuR9Q_ao_9G9_VQ5MtoaK1ZLJstL=yWfe0N9Pg5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RESEND v1 0/3] add support for VCPU event
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "famz@redhat.com" <famz@redhat.com>, "james.morse@arm.com" <james.morse@arm.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Linuxarm <linuxarm@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

On 1 June 2018 at 15:16, gengdongjiu <gengdongjiu@huawei.com> wrote:
> Hi Peter,

>> You should wait for that to get into master (it is in Paolo's most
>> recent patchset but that has an issue with a different patch, so
>> is waiting on Paolo to do a respin). Then you can base on that. At
>> that point a simple script update should work fine (if you need
>> anything in rc7 that wasn't in rc6).
>
> Ok, got it. Thanks a lot for the explanation, I will wait for your
> patch[1] merge into master and based on it.

The rc6 header update is now in QEMU git master.

thanks
-- PMM
