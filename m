Received: from eggs.gnu.org ([2001:4830:134:3::10]:55584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHvDT-00038h-QI
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHvDQ-0002Rg-Na
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:50:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHvDQ-0002QV-Gb
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:50:52 -0400
Date: Mon, 5 Jun 2017 12:50:50 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1341142740.5922306.1496681450441.JavaMail.zimbra@redhat.com>
In-Reply-To: <da0c88bf-061d-190f-9cfd-4b5fbeee7424@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
	<1496320911-51305-18-git-send-email-pbonzini@redhat.com>
	<c39f198a-1b68-5d39-1c9a-7eaecb8d96d9@redhat.com>
	<EE0BCD97-9983-4753-B690-FE9BD68A6E3A@nutanix.com>
	<da0c88bf-061d-190f-9cfd-4b5fbeee7424@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 17/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Felipe Franciosi <felipe@nutanix.com>, qemu-devel <qemu-devel@nongnu.org>



----- Original Message -----
> From: "Eric Blake" <eblake@redhat.com>
> To: "Felipe Franciosi" <felipe@nutanix.com>
> Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "qemu-devel" <qemu-devel@nongnu.org>
> Sent: Monday, June 5, 2017 6:41:33 PM
> Subject: Re: [Qemu-devel] [PULL 17/33] vhost-user-scsi: Introduce vhost-user-scsi host device
> 
> On 06/05/2017 11:38 AM, Felipe Franciosi wrote:
> 
> >>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> >>> Message-Id: <1488479153-21203-4-git-send-email-felipe@nutanix.com>
> >>> ---
> >>
> >> This pull request still hasn't landed, and now it needs a rebase:
> > 
> > Hi Eric,
> > 
> > Thanks for the report. Looks simple. Part of the series have been merged.
> > Should I rebase+resend just the two missing patches (as a new series?) or
> > should Paolo do this? I'm not sure what's the workflow here.
> 
> Paolo has to re-spin his PULL request, but I'm sure it would help him to
> have updated patches from you that work out of the box, instead of
> making him figure out the changes that have to be made.

I have to retest everything anyway.  But it'll have to wait for tomorrow
or later, because I have other stuff to do.

Paolo
