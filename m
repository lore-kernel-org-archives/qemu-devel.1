Received: from eggs.gnu.org ([2001:4830:134:3::10]:56594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fv5dl-00075m-U7
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 14:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fv5di-0006VA-P1
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 14:56:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180828123346.17548-1-cohuck@redhat.com>
Date: Wed, 29 Aug 2018 20:56:22 +0200
In-Reply-To: <20180828123346.17548-1-cohuck@redhat.com> (Cornelia Huck's
	message of "Tue, 28 Aug 2018 14:33:43 +0200")
Message-ID: <87y3cp6lyh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/3] qemu-error: advanced report_once
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

Cornelia Huck <cohuck@redhat.com> writes:

> Based on previous discussions, I wanted to enhance the recently
> merged report_once infrastucture with a way to print a message
> once based on a variable instead of globally-once, similar to
> what vfio-ccw uses today.
>
> Not really tested, mainly wanted to get this out before my vacation
> to get the ball rolling.

I had a few comments, but found nothing serious enough to withhold my
Reviewed-by: Markus Armbruster <armbru@redhat.com>
