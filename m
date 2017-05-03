Received: from eggs.gnu.org ([2001:4830:134:3::10]:49345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5zEv-00072F-W4
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5zEs-0001lL-Mb
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:43:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d5zEs-0001kh-Gb
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:43:02 -0400
References: <20170503094351.5040-1-pbonzini@redhat.com>
	<20170503094351.5040-2-pbonzini@redhat.com>
	<dbfed08f-8beb-8b85-4d2c-fc31813426a7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c02874d0-54d7-b81e-b48c-b397df92b84f@redhat.com>
Date: Wed, 3 May 2017 20:42:56 +0200
MIME-Version: 1.0
In-Reply-To: <dbfed08f-8beb-8b85-4d2c-fc31813426a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] MAINTAINERS: Add "R:" tag for
 self-appointed reviewers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, armbru@redhat.com, pavel.dovgaluk@ispras.ru



On 03/05/2017 20:23, John Snow wrote:
>>
>> Seriously: the purpose here is a bit different from the Linux kernel.
>> While Linux uses "R" to designate non-maintainers for reviewing patches
>> in a given area, in QEMU I would also like to use "R" so that people can
>> delegate sending pull requests while keeping some degree of oversight.
>>
> Hm? I don't follow -- you mean to say that "R" is also a designated
> pull-request-sender? Did you document that anywhere?

No, "M" would be the pull request sender, while "R" would be me
delegating while keeping an eye on what's going on.

Paolo
