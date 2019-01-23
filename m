Received: from eggs.gnu.org ([209.51.188.92]:49098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmBMv-00004u-JK
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 00:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmBMu-0004YV-V1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 00:46:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmBMu-0004Xz-Mw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 00:46:32 -0500
References: <1544684731-18828-1-git-send-email-thuth@redhat.com>
	<9be7ef6d-15b2-6e82-7beb-aeb287b50c3b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cdb2688d-3495-bfe0-3cfe-0424d310f37c@redhat.com>
Date: Wed, 23 Jan 2019 06:46:25 +0100
MIME-Version: 1.0
In-Reply-To: <9be7ef6d-15b2-6e82-7beb-aeb287b50c3b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-options: Remove deprecated
 "-virtioconsole" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com

On 2018-12-13 14:18, Paolo Bonzini wrote:
> On 13/12/18 08:05, Thomas Huth wrote:
>> It's been deprecated since QEMU 3.0, and nobody complained so far, so
>> it is time to remove this option now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Queued (for the next pull request, not this one).

Ping? ... looks like this might have fallen through the cracks?

 Thomas
