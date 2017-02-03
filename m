Received: from eggs.gnu.org ([2001:4830:134:3::10]:48175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cZaT8-00026D-MR
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cZaT3-0000t4-My
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:47:50 -0500
Received: from 14.mo1.mail-out.ovh.net ([178.32.97.215]:59550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cZaT3-0000l9-Gt
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:47:45 -0500
Received: from player770.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id C5BFF53E42
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 10:47:35 +0100 (CET)
Date: Fri, 3 Feb 2017 10:47:29 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170203104729.4c0ed00b@bahia.lan>
In-Reply-To: <b8467f6a-6cca-4b24-50f3-dd2dbafa8c02@huawei.com>
References: <1485249848-13854-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51d1f2rmx9.fsf@maestria.local.igalia.com>
	<b8467f6a-6cca-4b24-50f3-dd2dbafa8c02@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2 v14] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Fri, 3 Feb 2017 10:41:33 +0100
Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> wrote:

> On 2/1/2017 3:44 PM, Alberto Garcia wrote:
> > On Tue 24 Jan 2017 10:24:06 AM CET, Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:
> >  
> >> Pradeep Jagadeesh (2):
> >>   fsdev: add IO throttle support to fsdev devices
> >>   throttle: removed duplicate throtlle code from block and fsdev files  
> >
> > I cannot find the second patch in this thread (v14), did you forget to
> > send it?
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg04913.html  
> 
> Sorry for the late reply.
> 
> I did send all the both patch files and the cover letter.
> Don't know how the patch missed in that link.
> 
> I have received independent e-mails for each patch, with version 14.
> Am I missing something here?
> 

Hi,

Patch 2/2 still doesn't appear in the archives:

https://lists.gnu.org/archive/html/qemu-devel/2017-01/threads.html#04913

And I haven't received it either...

Cheers.

--
Greg

> Regards,
> Pradeep
> 
> 
> >
> > Berto
> >  
> 
