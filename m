Received: from eggs.gnu.org ([2001:4830:134:3::10]:53855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHv61-00087P-9X
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHv5y-0002eq-5y
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:20:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHv5x-0002eL-Te
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:19:58 -0400
References: <20180916124631.39016-1-liran.alon@oracle.com>
	<EFF8C049-EE78-4035-A38E-6A91EA219878@oracle.com>
	<80DAB33E-A982-4903-AEBA-F71AB2E8AFC3@oracle.com>
	<5F34DE35-D1EE-441A-87A1-379C7A04AFE7@oracle.com>
	<20181031181759.GR3902@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5b6cdf7-6ff9-7bd8-d591-3e2669b4f802@redhat.com>
Date: Wed, 31 Oct 2018 19:19:52 +0100
MIME-Version: 1.0
In-Reply-To: <20181031181759.GR3902@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Liran Alon <liran.alon@oracle.com>
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com, rth@twiddle.net, kvm@vger.kernel.org, jmattson@google.com

On 31/10/2018 19:17, Eduardo Habkost wrote:
> On Wed, Oct 31, 2018 at 03:03:34AM +0200, Liran Alon wrote:
>> Ping.
>> Patch was submitted almost two months ago and I haven=E2=80=99t seen a=
ny respond for the v2 of this series.
> Sorry for the long delay.  This was on my queue of patches to be
> reviewed, but I'm failing to keep up to the rate of incoming
> patches.  I will try to review the series next week.

I have already reviewed it; unfortunately I have missed the soft freeze
for posting the version I had also been working on when Liran posted
these patches.

Paolo
