Received: from eggs.gnu.org ([2001:4830:134:3::10]:51540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eFc6O-0005fY-FC
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eFc6L-0001RM-Df
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:34:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:60450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1eFc6L-0001Q3-4H
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:34:17 -0500
References: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
	<81495d39-0026-dba2-10b9-86d7df5babd3@tuxfamily.org>
	<4a983bfc-442c-c55f-e3eb-9cb58a0d9ba8@redhat.com>
	<aac92ba4-337c-df4f-c8f5-03b9fef1e2f0@linux.intel.com>
	<cdd6e0a4-93cd-66ca-5e69-7a834f0b10d0@redhat.com>
	<a1648b4d-946f-49c4-93c5-5990baa0bce8@linux.intel.com>
	<3cc5c809-001e-bb14-52fd-7a66ed00b38c@redhat.com>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <541c82ef-9798-377a-8c79-f3aa0387324c@linux.intel.com>
Date: Fri, 17 Nov 2017 16:34:08 +0800
MIME-Version: 1.0
In-Reply-To: <3cc5c809-001e-bb14-52fd-7a66ed00b38c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] HAXM is now open source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <huth@tuxfamily.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Cc: John Snow <jsnow@redhat.com>, Vincent Palatin <vpalatin@chromium.org>



On 11/17/2017 16:30, Thomas Huth wrote:
> On 17.11.2017 09:17, Yu Ning wrote:
> [...]
>> Is there a preferred document format for the QEMU blog, e.g. Markdown?
> Yes, we're using markdown of Jekyll (https://jekyllrb.com/docs/posts/).
> Please clone the qemu-web repository (see
> https://git.qemu.org/?p=qemu-web.git), and have a look in the "_posts"
> directory to see how the files should look like.
>
>> I'll get the content ready by early next week, and then I'll need
>> someone to help me post it.
> Sure, Paolo and I should be able to help. The preferred way is to create
> a patch against the qemu-web repository and send that patch to
> qemu-devel, with CC: to Paolo and myself. We then can give feedback, do
> sanity checking (in case you don't want to install Jekyll on your HD),
> and push the patch to the website if everything is fine.

Got it, thanks!
