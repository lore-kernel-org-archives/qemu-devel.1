Received: from eggs.gnu.org ([2001:4830:134:3::10]:34577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cfnwi-0007H8-IN
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cfnwh-0007fd-HW
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:24:04 -0500
Date: Mon, 20 Feb 2017 08:23:55 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49937814.23682538.1487597035306.JavaMail.zimbra@redhat.com>
In-Reply-To: <878tp1yp4l.fsf@dusky.pond.sub.org>
References: <1487161136-9018-1-git-send-email-armbru@redhat.com>
	<575ab227-e44e-8d66-7b58-3e68e1df8491@redhat.com>
	<878tp7tx98.fsf@dusky.pond.sub.org>
	<ca73f39c-04b2-ce0b-1f80-5eef0e4861ce@redhat.com>
	<87poidkqv4.fsf@dusky.pond.sub.org>
	<35ce9aed-b82a-3270-a4a9-12f2e1782b9d@redhat.com>
	<878tp1yp4l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] hw: Deprecate unwanted use -drive
 if=scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, peter maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

> >>>> Is that an Acked-by?
> >>>
> >>> Not a sufficient one because the patch touches files outside my area of
> >>> maintenance, but for hw/scsi you can treat it as one.
> >> 
> >> Okay, that covers PATCH 1/3.
> >> 
> >> What about PATCH 3/3?  It's actually your idea...
> >
> > Yep, hw/i386 too I guess.
> 
> Do you mean the he/i386 part of PATCH 2/3?  How would I express that?
> Acked-by goes into the commit message, not individual files...

I mean that you only need Peter to ack now.

Paolo
