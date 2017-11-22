Received: from eggs.gnu.org ([2001:4830:134:3::10]:48632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eHWOi-00059a-50
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eHWOe-0000Io-8D
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:53:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:17321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1eHWOe-0000IB-03
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:53:04 -0500
References: <1511338200-20417-1-git-send-email-yu.ning@linux.intel.com>
	<18c1591d-a46a-cd22-fd1c-d87780829622@redhat.com>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <7ce3a417-da98-c5b8-ff6c-ab43d91b63da@linux.intel.com>
Date: Wed, 22 Nov 2017 22:52:59 +0800
MIME-Version: 1.0
In-Reply-To: <18c1591d-a46a-cd22-fd1c-d87780829622@redhat.com>
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
Cc: qemu-devel@nongnu.org, huth@tuxfamily.org, jsnow@redhat.com, sw@weilnetz.de, Yu Ning <yu.ning@intel.com>



On 11/22/2017 20:25, Thomas Huth wrote:
> On 22.11.2017 09:10, Yu Ning wrote:
>> From: Yu Ning <yu.ning@intel.com>
>>
>> Following my announcement of the open source release of HAXM,
>> I was asked to write a blog post for normal Windows users to
>> advertise the use of "-accel hax":
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg02822.html
> Thanks a lot, that blog post looks very good to me!

Thanks!

> ... just the width of the qemu-debian-wheezy-gui-with-haxm.png image
> seems to cause some rendering ugliness in my webbrowser, causing the
> text to overflow into the right menu:
>
> http://people.redhat.com/~thuth/screenshot-haxm-blog.png
>
> Would it be OK to remove the qemu-debian-wheezy-gui-with-haxm.png from
> the blog post?

Yes, I'm fine with removing it.  Sorry I haven't installed Jekyll and 
didn't test the rendering.

Would you confirm whether that's the only change I need to make in v2?
