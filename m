Received: from eggs.gnu.org ([2001:4830:134:3::10]:48307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eT-0007Z2-9A
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eS-00081x-DP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487161136-9018-1-git-send-email-armbru@redhat.com>
	<575ab227-e44e-8d66-7b58-3e68e1df8491@redhat.com>
	<878tp7tx98.fsf@dusky.pond.sub.org>
	<ca73f39c-04b2-ce0b-1f80-5eef0e4861ce@redhat.com>
	<87poidkqv4.fsf@dusky.pond.sub.org>
	<35ce9aed-b82a-3270-a4a9-12f2e1782b9d@redhat.com>
	<878tp1yp4l.fsf@dusky.pond.sub.org>
	<49937814.23682538.1487597035306.JavaMail.zimbra@redhat.com>
Date: Tue, 21 Feb 2017 13:34:32 +0100
In-Reply-To: <49937814.23682538.1487597035306.JavaMail.zimbra@redhat.com>
	(Paolo Bonzini's message of "Mon, 20 Feb 2017 08:23:55 -0500 (EST)")
Message-ID: <87r32ru3hj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kwolf@redhat.com, peter maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Paolo Bonzini <pbonzini@redhat.com> writes:

>> >>>> Is that an Acked-by?
>> >>>
>> >>> Not a sufficient one because the patch touches files outside my area of
>> >>> maintenance, but for hw/scsi you can treat it as one.
>> >> 
>> >> Okay, that covers PATCH 1/3.
>> >> 
>> >> What about PATCH 3/3?  It's actually your idea...
>> >
>> > Yep, hw/i386 too I guess.
>> 
>> Do you mean the he/i386 part of PATCH 2/3?  How would I express that?
>> Acked-by goes into the commit message, not individual files...
>
> I mean that you only need Peter to ack now.

I guess an easy way to ask him would be a pull request ;-P
