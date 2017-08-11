Received: from eggs.gnu.org ([2001:4830:134:3::10]:57161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dgDZl-0002eH-Gy
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dgDZi-0006ut-Ax
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:18:21 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dgDZi-0006ue-5j
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:18:18 -0400
Received: by mail-oi0-x243.google.com with SMTP id s21so3870717oie.5
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 10:18:18 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
Date: Fri, 11 Aug 2017 12:18:15 -0500
In-Reply-To: <f5d6b3dc-3b05-e93a-8b6f-60c9fd922efb@redhat.com>
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-5-david@redhat.com>
	<f5d6b3dc-3b05-e93a-8b6f-60c9fd922efb@redhat.com>
MIME-Version: 1.0
From: Richard Henderson <rth@twiddle.net>
Message-ID: <B286F420-B2F7-407A-978A-A5D100CD0375@twiddle.net>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 4/5] target/s390x: remove all
 CONFIG_KVM from cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

It's not all kvm related, so I'd prefer the more general name=2E

r~

On August 11, 2017 9:19:52 AM CDT, Thomas Huth <thuth@redhat=2Ecom> wrote:
>On 11=2E08=2E2017 09:46, David Hildenbrand wrote:
>> Let's move everything into internal=2Eh
>
>Or kvm_s390x=2Eh ? ;-)
>
> Thomas

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
