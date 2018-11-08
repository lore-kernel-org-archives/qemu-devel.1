Received: from eggs.gnu.org ([2001:4830:134:3::10]:42183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKm13-0005tm-Vp
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKm12-0000ZT-6n
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:14:41 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKm11-0000VU-Ui
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:14:40 -0500
Received: by mail-oi1-x242.google.com with SMTP id j202-v6so17166026oih.10
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 07:14:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b123d5e2-7262-a695-a53c-8fce888a7ce0@redhat.com>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
	<b123d5e2-7262-a695-a53c-8fce888a7ce0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 15:14:12 +0000
Message-ID: <CAFEAcA_B6E=h8i4UAGrVRKhYrX1STSM3Gr2pZsVsQtE25xUwfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/22] ppc-for-3.1 queue 20181108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 8 November 2018 at 14:45, Eric Blake <eblake@redhat.com> wrote:
> On 11/8/18 6:16 AM, David Gibson wrote:
>>
>> The following changes since commit
>> 4de6bb0c02ad3f0ec48f0f84ba1a65ab06e81b86:
>>
>>    Update version for v3.1.0-rc0 release (2018-11-06 18:27:35 +0000)
>>
>
>>
>> Maria Klimushenkova (1):
>>        This patch fixes processing of rfi instructions in icount mode.
>
>
> Repeating the comment on 20/22 here, in case David wants to send a v2 respin
> of the PR before Peter applies this subject line as-is.

...sorry, already pushed to master before I saw this.

thanks
-- PMM
