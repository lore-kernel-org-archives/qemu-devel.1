Received: from eggs.gnu.org ([2001:4830:134:3::10]:41301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHoMN-0000MW-OK
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHoMK-0000CK-LL
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:03:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eHoMK-0000Bf-E0
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:03:52 -0500
Date: Thu, 23 Nov 2017 11:03:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171123110345.03541b50.cohuck@redhat.com>
In-Reply-To: <715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU 3.0 ? (was: [PATCH for-2.12 v3 01/11] spapr:
 add pseries 2.12 machine type)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>

On Mon, 13 Nov 2017 08:14:28 +0100
Thomas Huth <thuth@redhat.com> wrote:

> By the way, before everybody now introduces "2.12" machine types ... is
> there already a consensus that the next version will be "2.12" ?
> 
> A couple of months ago, we discussed that we could maybe do a 3.0 after
> 2.11, e.g. here:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05056.html
> 
> I'd still like to see that happen... Peter, any thoughts on this?

So, as I just thought about preparing the new machine for s390x as
well: Did we reach any consensus about what the next qemu version will
be called?
