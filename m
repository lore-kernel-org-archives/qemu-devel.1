Received: from eggs.gnu.org ([2001:4830:134:3::10]:42287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1duHuP-0000XA-Ps
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1duHuO-0007pR-NF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:45:49 -0400
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233]:55300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1duHuO-0007oi-G1
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:45:48 -0400
Received: by mail-io0-x233.google.com with SMTP id z187so9579361ioz.12
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<FF7FC980937D6342B9D289F5F3C7C2625B5AEDAE@SHSMSX152.ccr.corp.intel.com>
	<CAJ+F1CJ2q7-YX0Sww+sV9Sx0s0sViN++G-Q81P2hupwaZfztRw@mail.gmail.com>
In-Reply-To: <CAJ+F1CJ2q7-YX0Sww+sV9Sx0s0sViN++G-Q81P2hupwaZfztRw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Sep 2017 12:45:35 +0000
Message-ID: <CAJ+F1CJBR=vAvAt7vNA=GRc+7J1vUm4k7=CLGAG=MJ1rEEor_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/27] vhost-user-scsi: code clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "felipe@nutanix.com" <felipe@nutanix.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Hi

On Mon, Sep 11, 2017 at 3:18 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Thu, Aug 24, 2017 at 2:41 AM Liu, Changpeng <changpeng.liu@intel.com>
> wrote:
>
>> Thanks for helping the example code clean-up. I can rebase the
>> vhost-user-blk patch
>> set after your commits. For the issue you mentioned below, I think the
>> vhost-user-scsi example
>> can only support 1 LUN, so LUN0 is exist, LUN1 reported error should be
>> okay.
>>
>
> I think this series should go first before your vhost-user-blk, to avoid
> code churn. Please help review.
>
> Patches missing review: 1, 2, 3, 5, 8, 9, 10, 11, 13, 17, 20, 22, 24, 25,
> 26
>

Now missing 3, 8, 10, 11, 13, 17, 22, 24.

Many thanks Philippe so far!

--=20
Marc-Andr=C3=A9 Lureau
