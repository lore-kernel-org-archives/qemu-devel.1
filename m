Received: from eggs.gnu.org ([2001:4830:134:3::10]:58767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eJrCc-00068b-IK
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eJrCY-0006Ms-KN
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:30:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:51978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1eJrCY-0006Lt-AR
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:30:14 -0500
References: <151134740734.552.186654908491769740@bafd83ae6430>
	<3d7b93b2-76b1-cfc4-f87b-8983a8439bb7@redhat.com>
	<20171129012511.GA8889@lemon>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <93609838-1bd7-6b08-ebda-538dac98f2f7@linux.intel.com>
Date: Wed, 29 Nov 2017 09:30:08 +0800
MIME-Version: 1.0
In-Reply-To: <20171129012511.GA8889@lemon>
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
To: Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, no-reply@patchew.org, huth@tuxfamily.org, sw@weilnetz.de, yu.ning@intel.com, pbonzini@redhat.com, jsnow@redhat.com, patchew-devel@freelists.org



On 11/29/2017 9:25, Fam Zheng wrote:
> On Tue, 11/28 13:57, Eric Blake wrote:
>> On 11/22/2017 04:43 AM, no-reply@patchew.org wrote:
>>> Hi,
>>>
>>> This series failed automatic build test. Please find the testing commands and
>>> their output below. If you have docker installed, you can probably reproduce it
>>> locally.
>>>
>>> Subject: [Qemu-devel] [PATCH] Add a blog post about HAXM acceleration on Windows
>>> Type: series
>>> Message-id: 1511338200-20417-1-git-send-email-yu.ning@linux.intel.com
>> Just now noticing this, but it's impressive that:
>>
>>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>>> Switched to a new branch 'test'
>>> 73987e06df Add a blog post about HAXM acceleration on Windows
>> the patch even applied, even though it wasn't against qemu.git!  Is it
>> possible to teach patchew to ignore patches against the website, as that is
>> maintained in a separate repository?
> This patch was supposed to have "[qemu-web PATCH]" or "[PATCH web]" in the
> subject. That way it wouldn't be processed by patchew. (I think that is in
> general a good way to state which repo the series is targeting at.)

I see.  Sorry I didn't know about that and used the wrong prefix. Is it 
documented on the wiki?

Thanks,
Yu
