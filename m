Received: from eggs.gnu.org ([2001:4830:134:3::10]:36152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePXEt-0002Sv-Lj
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:24:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePXEs-0003IG-W7
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:24:07 -0500
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-5-jsnow@redhat.com>
	<0ac30feb-553b-cfa3-070a-0f703c4e0f10@redhat.com>
	<1b7494a6-aca5-41e8-469b-e2b9d8aade67@redhat.com>
	<b0969a32-fa45-a4f5-0768-959750622698@redhat.com>
	<a0cb18cf-61b1-a18a-d2b0-4a536aca51e2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa04852b-a05b-fbec-a69f-27d9e5d621a2@redhat.com>
Date: Thu, 14 Dec 2017 18:23:50 +0100
MIME-Version: 1.0
In-Reply-To: <a0cb18cf-61b1-a18a-d2b0-4a536aca51e2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] blockjob: allow block_job_throttle to
 take delay_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

On 14/12/2017 18:22, John Snow wrote:
>> Ok, shall we wait for v2 where you look at that BZ as well?
>
> Sure -- if the only feedback you have on this series is primarily style
> and "maybe there are some more wins" I can spin a v2 to try to broaden
> the scope if it looks good so far.

Yeah, that's pretty much it (except that it isn't "maybe there are some
more wins", but rather "going from two to three functions isn't exactly
what I was hoping for" :)).

Paolo
