Received: from eggs.gnu.org ([2001:4830:134:3::10]:57605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eHglY-0000tP-1F
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 20:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eHglU-0003BA-Vh
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 20:57:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:62054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1eHglU-0003AP-Mc
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 20:57:20 -0500
References: <1511338200-20417-1-git-send-email-yu.ning@linux.intel.com>
	<18c1591d-a46a-cd22-fd1c-d87780829622@redhat.com>
	<7ce3a417-da98-c5b8-ff6c-ab43d91b63da@linux.intel.com>
	<8bc6cb19-a05f-e592-1e4d-a5af15c0e67f@redhat.com>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <837e51f5-a82e-31ba-3793-2781c66db26a@linux.intel.com>
Date: Thu, 23 Nov 2017 09:57:14 +0800
MIME-Version: 1.0
In-Reply-To: <8bc6cb19-a05f-e592-1e4d-a5af15c0e67f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] Add a blog post about HAXM acceleration on
 Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, sw@weilnetz.de, Yu Ning <yu.ning@intel.com>



On 11/23/2017 1:03, Thomas Huth wrote:
> On 22.11.2017 15:52, Yu Ning wrote:
>> On 11/22/2017 20:25, Thomas Huth wrote:
> [...]
>>> Would it be OK to remove the qemu-debian-wheezy-gui-with-haxm.png from
>>> the blog post?
>> Yes, I'm fine with removing it.  Sorry I haven't installed Jekyll and
>> didn't test the rendering.
>>
>> Would you confirm whether that's the only change I need to make in v2?
> No need to respin, since this was just a one-line change, I was able to
> do it on my own (I still removed the screenshot, even if it seemed to be
> working with Paolo's patch to the CSS, since the screenshot looked just
> a bit too big for the blog - I hope that's OK for you).

Yes, absolutely :)

> So the blog post is now online:
>
>   https://www.qemu.org/2017/11/22/haxm-usage-windows/

Looks nice, thanks!
