Received: from eggs.gnu.org ([2001:4830:134:3::10]:36715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJmq-0002pI-0V
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJml-00008k-Se
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:46:08 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:43146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duJml-00007x-MB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:46:03 -0400
Received: by mail-wm0-f42.google.com with SMTP id a137so213452wma.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 07:46:03 -0700 (PDT)
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<FF7FC980937D6342B9D289F5F3C7C2625B5AEDAE@SHSMSX152.ccr.corp.intel.com>
	<CAJ+F1CJ2q7-YX0Sww+sV9Sx0s0sViN++G-Q81P2hupwaZfztRw@mail.gmail.com>
	<CAJ+F1CJBR=vAvAt7vNA=GRc+7J1vUm4k7=CLGAG=MJ1rEEor_g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <65582637-027f-b7de-c5b4-3da95089a78f@redhat.com>
Date: Tue, 19 Sep 2017 16:46:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJBR=vAvAt7vNA=GRc+7J1vUm4k7=CLGAG=MJ1rEEor_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/27] vhost-user-scsi: code clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Liu, Changpeng" <changpeng.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "felipe@nutanix.com" <felipe@nutanix.com>

On 19/09/2017 14:45, Marc-André Lureau wrote:
> Now missing 3, 8, 10, 11, 13, 17, 22, 24.

Done, only some doubts on patch 13.

Paolo
