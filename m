Received: from eggs.gnu.org ([2001:4830:134:3::10]:44839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEap6-0008Cd-N1
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEap1-0004uu-TN
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:32:32 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:33968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEap1-0004uL-Oc
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:32:27 -0400
Received: by mail-oi0-x22d.google.com with SMTP id l1-v6so19133294oii.1
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 06:32:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504152658.3537707a.cohuck@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-61-git-send-email-mst@redhat.com>
	<20180504091007.55405a6a.cohuck@redhat.com>
	<be79d6dd-beaa-ba6f-2990-b5e91139411b@redhat.com>
	<20180504152658.3537707a.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 14:32:06 +0100
Message-ID: <CAFEAcA_xZZ5=oa-rA0=qh2-wxrt14KqH38rdg_OVLrqoTfzA9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] cover letter cc's [was: [PATCH 60/67] hw/s390x:
 add include directory headers]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-s390x <qemu-s390x@nongnu.org>, git@vger.kernel.org

On 4 May 2018 at 14:26, Cornelia Huck <cohuck@redhat.com> wrote:
> On Fri, 4 May 2018 08:07:53 -0500
> Eric Blake <eblake@redhat.com> wrote:
>> On the other hand, cc'ing all recipients for a largely mechanical patch
>> series that was split into 67 parts, in part because it touches so many
>> different maintainers' areas, may make the cover letter have so many
>> recipients that various mail gateways start rejecting it as potential spam.
>
> Yes, large cross-subsystem patch series make this painful.

My solution is to either (a) avoid them or (b) not bother cc'ing
people (except people I think might be interested in reviewing
cross-subsystem patchsets like Eric ;-))...

thanks
-- PMM
