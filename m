Received: from eggs.gnu.org ([2001:4830:134:3::10]:58879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNi28-0002E8-BD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNi23-0001iV-UH
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:35:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNi23-0001hh-OA
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:35:51 -0500
References: <CAFEAcA8WWmwjY+derXd-yM==QmPtP7C3TN3pC0TCTPwVFdhZNA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08c4103d-4bf2-19c7-f33e-096e16b1bde2@redhat.com>
Date: Fri, 16 Nov 2018 11:35:48 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8WWmwjY+derXd-yM==QmPtP7C3TN3pC0TCTPwVFdhZNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU Summit 2018 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 11/16/18 11:23 AM, Peter Maydell wrote:
> As usual, during this year's KVM Forum we also held the
> QEMU Summit, which is where the more active subsystem
> maintainers meet up for a discussion of various maintenance
> and other project issues. As always, none of this is set-in-stone
> decisions; further input and discussion on-list is welcome.
> 

>   * QEMU Leadership Committee: Are changes to committee membership
>     necessary (it's been 3 years)?
> 
>     The Leadership Committee represents QEMU in the Software Freedom
>     Conservancy (the legal home for our project).  At the moment no
>     urgent changes are necessary, but we're open to suggestions for new
>     members.

No urgent changes were necessary at the time of the KVM Forum, but 
subsequent announcements about the IBM and Red Hat relationship may 
require a change in the next year, to avoid having too many members from 
the same company.

> 
>   * MAINTAINERS "R:" (designated reviewer): should this be open to
>     anyone?
> 
>     The maintainer still merges patches, but R: people have expressed an
>     interest in reviewing patches and should be CCed.  There is debate as
>     to what exactly R: means.  R: doesn't imply that the person is a
>     maintainer although it is sometimes considered as having authority
>     over the code.
> 
>     Cornelia Huck will send patch to clarify the exact meaning of R:.  It
>     will be up to the maintainer to decide who can be added to R:.

Patch available here, if you want to add discussion:
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02996.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
