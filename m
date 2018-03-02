Received: from eggs.gnu.org ([2001:4830:134:3::10]:36681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eri3B-0006fm-Ox
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eri37-0001tf-RP
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:36:29 -0500
Date: Fri, 2 Mar 2018 11:36:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180302113604.647832c3.cohuck@redhat.com>
In-Reply-To: <20180227200655.23e452d1.cohuck@redhat.com>
References: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518797321-28356-5-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180219155728.00d0075e.cohuck@redhat.com>
	<1fba4dff-e252-93af-da3b-ce81f6edf55b@linux.vnet.ibm.com>
	<20180227200655.23e452d1.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv5 4/5] qemu-doc: deprecate query-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

On Tue, 27 Feb 2018 20:06:55 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 27 Feb 2018 14:41:38 +0100
> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> 
> > On 19.02.2018 15:57, Cornelia Huck wrote:  
> > > On Fri, 16 Feb 2018 17:08:40 +0100
> > > Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> > >     
> > >> Start the deprecation period for QAPI query-cpus (replaced by
> > >> query-cpus-fast) beginning with 2.12.0.
> > >>
> > >> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> > >> Reviewed-by: Eric Blake <eblake@redhat.com>
> > >> ---
> > >>  qapi-schema.json | 4 ++++
> > >>  qemu-doc.texi    | 4 ++++
> > >>  2 files changed, 8 insertions(+)    
> > > 
> > > We need to remember updating the deprecation notes in the wiki as well.
> > > 
> > > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > >     
> > Let me know whether you plan on doing that or I should take a crack at it.
> >   
> 
> If I haven't managed to update it by softfreeze, feel free to do so :)

OK, added to the 2.12 changelog.
