Received: from eggs.gnu.org ([2001:4830:134:3::10]:56314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsFna-0006vr-DF
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsFnZ-00079C-DT
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:06:22 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<83c3006b-d62e-441b-57f1-dea64b141c11@redhat.com>
	<20170913075914.GA3929@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c085442-744b-e08c-279c-fc0c74559551@redhat.com>
Date: Thu, 14 Sep 2017 00:06:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170913075914.GA3929@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/10] cleanup qemu-iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

On 13/09/2017 09:59, Fam Zheng wrote:
> On Wed, 09/13 08:47, Thomas Huth wrote:
>> Meta comment: Could we maybe also rename "tests/qemu-iotests" to
>> "tests/iotests" ? The "qemu" prefix sounds always very superfluous to me
>> here...
> 
> Sounds good, and saves typing for when this path is manually entered. But maybe
> keep tests/qemu-iotests as a symlink to keep old scripts happy?

The simplest way to keep old scripts happy would be too keep the prefix
:) even though it does sound unnecessary.

Paolo
