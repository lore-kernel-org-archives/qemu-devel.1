Received: from eggs.gnu.org ([2001:4830:134:3::10]:41156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dJiXQ-0005pV-5y
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 11:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dJiXN-00083T-4z
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 11:42:56 -0400
Message-ID: <1497109365.4161.1.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Sat, 10 Jun 2017 17:42:45 +0200
In-Reply-To: <20170602031507.29881-1-david@gibson.dropbear.id.au>
References: <20170602031507.29881-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv5 0/4] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, clg@kaod.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Cc: sbobroff@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Fri, 2017-06-02 at 13:15 +1000, David Gibson wrote:
> This is a rebased and revised version of my patches revising CPU
> compatiblity mode handling on ppc, last posted in November.=C2=A0=C2=A0=
Since
> then, many of the patches have already been merged (some for 2.9, some
> since).=C2=A0=C2=A0This is what's left.

I've tested this the same way I had tested one of the
previous respins, eg. for basic usage and general sanity
of the interface. All the issues I pointed out last time
seems to have been addressed.


Tested-by: Andrea Bolognani <abologna@redhat.com>

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
